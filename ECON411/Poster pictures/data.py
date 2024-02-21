import requests
from bs4 import BeautifulSoup
import re


def get_conventions_by_country_and_year(url):
    # Send a request to the website
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')

    # Initialize a dictionary to hold the count of conventions
    conventions = {}

    # Find all event entries
    events = soup.find_all('div', class_='event')  # Adjust class based on actual webpage structure

    for event in events:
        # Extract year and country from each event
        details = event.text
        year_search = re.search(r'\b\d{4}\b', details)
        year = year_search.group(0) if year_search else 'Unknown'

        # Example country extraction (this needs to be adapted)
        country_search = re.search(r'Country_pattern', details)  # Replace 'Country_pattern' with an actual pattern
        country = country_search.group(0) if country_search else 'Unknown'

        # Increment the count in the dictionary
        if year not in conventions:
            conventions[year] = {}
        if country not in conventions[year]:
            conventions[year][country] = 0
        conventions[year][country] += 1

    return conventions


url = 'https://animecons.com/events/'
conventions_data = get_conventions_by_country_and_year(url)
print(conventions_data)