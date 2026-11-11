#!/usr/bin/env python3
"""Hedging analysis for the AIFS case (BUS 435).

The scenario: AIFS expects to pay EUR 10,000,000 for a study-abroad program
(10,000 participants at EUR 1,000 each).  It can remain unhedged, sell EUR
forward, or buy an option.  The table below compares the USD cost under three
exchange-rate scenarios.

Assumptions (edit the constants in ``main`` to explore alternatives):

* The base/planning rate is 1.22 USD/EUR.
* The 2-year forward rate equals the option strike, 1.2344 USD/EUR.
* The option premium is 5% of the notional value.
* A "positive" outcome means the hedged cost is below the planning cost.

Run with ``python aifs_hedge_strategy.py``.  The output is printed; no external
data or packages beyond pandas are required.
"""

from __future__ import annotations

from dataclasses import dataclass

import pandas as pd


@dataclass(frozen=True)
class Market:
    """Exchange-rate scenarios and contract terms."""

    base_rate: float
    forward_rate: float
    option_strike: float
    option_premium: float
    scenarios: dict[str, float]

    @property
    def stable_rate(self) -> float:
        return self.scenarios["Stable (0-Impact)"]


@dataclass(frozen=True)
class Exposure:
    """The EUR cash flows that need to be converted to USD."""

    volume: float
    cost_per_participant_eur: float

    @property
    def notional_eur(self) -> float:
        return self.volume * self.cost_per_participant_eur


def unhedged_costs(exposure: Exposure, market: Market) -> pd.DataFrame:
    """Cost of doing nothing, relative to the planning rate."""
    baseline = exposure.notional_eur * market.stable_rate
    rows = []
    for name, rate in market.scenarios.items():
        cost = exposure.notional_eur * rate
        windfall = cost - baseline
        rows.append(
            {
                "Scenario": name,
                "Rate (USD/EUR)": rate,
                "Total cost (USD)": cost,
                "Saving/(loss) vs. plan (USD)": windfall,
                "Impact": "Positive" if windfall < 0 else "Negative" if windfall > 0 else "Neutral",
            }
        )
    return pd.DataFrame(rows).set_index("Scenario")


def hedged_costs(exposure: Exposure, market: Market) -> pd.DataFrame:
    """Compare unhedged, forward-hedged, and option-hedged costs."""
    notional = exposure.notional_eur
    baseline = notional * market.stable_rate
    rows = []
    for name, rate in market.scenarios.items():
        forward_cost = notional * market.forward_rate
        effective_rate = min(rate, market.option_strike)
        option_cost = notional * effective_rate + baseline * market.option_premium
        rows.append(
            {
                "Scenario": name,
                "No hedging": notional * rate,
                "100% forward": forward_cost,
                "100% option": option_cost,
            }
        )
    return pd.DataFrame(rows).set_index("Scenario")


def net_exposure(
    market: Market,
    revenue_eur: float,
    cost_eur: float,
    sales_volume: float,
) -> dict[str, float]:
    """Net USD exposure per unit under forward and option hedges.

    This is the smaller illustration used at the end of the original script:
    a single sale with EUR revenue and EUR cost.
    """
    forward_revenue = revenue_eur * market.forward_rate
    forward_cost = cost_eur * market.forward_rate

    if market.option_strike > market.forward_rate:
        effective_option_rate = min(market.forward_rate, market.option_strike)
    else:
        effective_option_rate = max(market.forward_rate, market.option_strike)

    option_revenue = revenue_eur * effective_option_rate - market.option_premium * revenue_eur
    option_cost = cost_eur * effective_option_rate + market.option_premium * cost_eur

    return {
        "net_exposure_forward": (forward_revenue - forward_cost) * sales_volume,
        "net_exposure_option": (option_revenue - option_cost) * sales_volume,
    }


def main() -> None:
    market = Market(
        base_rate=1.22,
        forward_rate=1.2344,
        option_strike=1.2344,
        option_premium=0.05,
        scenarios={
            "Stable (0-Impact)": 1.22,
            "Strong Dollar": 1.01,
            "Weak Dollar": 1.48,
        },
    )
    exposure = Exposure(volume=10_000, cost_per_participant_eur=1_000)

    print("Unhedged exposure")
    print(unhedged_costs(exposure, market).to_string())

    print("\nHedging comparison (USD)")
    print(hedged_costs(exposure, market).to_string())

    print("\nNet exposure on a EUR 5,000 revenue / EUR 1,000 cost sale")
    print(
        net_exposure(
            market,
            revenue_eur=5_000,
            cost_eur=1_000,
            sales_volume=25_000,
        )
    )


if __name__ == "__main__":
    main()
