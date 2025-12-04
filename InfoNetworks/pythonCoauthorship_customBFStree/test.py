import networkx as nx
import matplotlib.pyplot as plt
import math

# Check if the year is valid and within the range 1985-2005
def is_valid_year(line):
    try:
        year = int(line.split()[0])
        return 1985 <= year <= 2005
    except ValueError:
        return False

# Load and filter data from the file
def load_and_filter_data(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()
    return [line for line in lines if is_valid_year(line)]

# Create a coauthorship graph from the filtered data
def create_coauthorship_graph(data):
    G = nx.Graph()
    for line in data:
        add_edges_from_authors(G, line)
    return G

# Add edges between coauthors in the graph
def add_edges_from_authors(G, line):
    authors = line.split(',')[0].split('&')
    authors = [author.strip() for author in authors]
    for i in range(len(authors)):
        for j in range(i + 1, len(authors)):
            G.add_edge(authors[i], authors[j])

# Get the largest connected component
def get_largest_component(G):
    largest_component = max(nx.connected_components(G), key=len)
    return G.subgraph(largest_component).copy()

# Problem 1: Calculate and plot the degree distribution
def solve_problem_1(G, netid):
    degree_count = calculate_degree_counts(G)

    # Construct the degree distribution to the file
    with open('hw1solution.txt', 'w') as f: # start the solution text file
        f.write(f'@ {netid}\n')
        for degree, count in sorted(degree_count.items()):
            f.write(f'@ 1 {degree} {count}\n')

    # Plotting the degree distribution
    plot_degree_distribution(degree_count, 'plot1.pdf')

# Calculate the degree counts for the graph
def calculate_degree_counts(G):
    degree_count = {}
    for _, degree in G.degree():
        degree_count[degree] = degree_count.get(degree, 0) + 1
    return degree_count

# Plot the degree distribution
def plot_degree_distribution(degree_count, filename):
    plt.figure()
    x = [math.log(d) for d in degree_count if d > 0]
    y = [math.log(degree_count[d]) for d in degree_count if d > 0]
    plt.scatter(x, y)
    plt.xlabel('log(Degree)')
    plt.ylabel('log(Count)')
    plt.title('Degree Distribution')
    plt.savefig(filename)

# Problem 2: Plotting connected components
def solve_problem_2(G):
    components = list(nx.connected_components(G))
    component_sizes = [len(component) for component in components]

    # Find the largest components and the ratio
    largest_component_size = max(component_sizes)
    total_nodes = len(G.nodes)
    ratio_largest = largest_component_size / total_nodes

    # Find the second largest component
    second_largest_component_size = sorted(component_sizes, reverse=True)[1]

    # Count the number of components of each size
    component_size_counts = {size: component_sizes.count(size) for size in set(component_sizes)}

    # Add Problem 2(a) results to the solution text file
    with open('hw1solution.txt', 'a') as f:
        f.write(f'@ 2 {largest_component_size} {total_nodes} {ratio_largest}\n')

    # Add results for Problem 2(b)
    for size in range(1, second_largest_component_size + 1):
        count = component_size_counts.get(size, 0)
        if count > 0:
            with open('hw1solution.txt', 'a') as f:
                f.write(f'@ 2 {size} {count}\n')

    # Plotting for Problem 2(c)
    plot_component_sizes(component_size_counts, second_largest_component_size, 'plot2.pdf')

# Plot the distribution of component sizes
def plot_component_sizes(component_size_counts, max_size, filename):
    plt.figure()
    x = [math.log(size) for size in component_size_counts.keys() if 1 <= size <= max_size and component_size_counts[size] > 0]
    y = [math.log(component_size_counts[size]) for size in component_size_counts.keys() if 1 <= size <= max_size and component_size_counts[size] > 0]
    plt.scatter(x, y)
    plt.xlabel('log(Component Size)')
    plt.ylabel('log(Number of Components)')
    plt.title('Component Sizes Distribution')
    plt.savefig(filename)

# Problem 3: Calculate distances from 'Gries'
def solve_problem_3(G, root):
    # Get the largest connected component
    largest_component = get_largest_component(G)
    
    # Set the root node as Gries
    root_node = root
    if root_node not in largest_component.nodes:
        root_node = list(largest_component.nodes)[0]  # Use the first node if Gries is not defined
    
    # Calculate distances from Gries
    distances = nx.single_source_shortest_path_length(largest_component, root_node) # Compute the shortest path lengths from Gries to all reachable nodes
    max_distance = max(distances.values())
    
    # Count nodes at each distance
    distance_counts = {dist: list(distances.values()).count(dist) for dist in range(1, max_distance + 1)}

    # Add results for Problem 3(a)
    with open('hw1solution.txt', 'a') as f:
        for dist, count in sorted(distance_counts.items()):
            f.write(f'@ 3 {dist} {count}\n')

    # Construct the histogram for Problem 3(b)
    plot_distances(distance_counts, 'plot3.pdf', root)

# Plot the distribution of distances from 'Gries'
def plot_distances(distance_counts, filename, root):
    plt.figure()
    plt.bar(distance_counts.keys(), distance_counts.values())
    plt.xlabel(f'Distance from {root}')
    plt.ylabel('Number of Nodes')
    plt.title(f'Distances from {root}')
    plt.savefig(filename)

# Problem 4: BFS tree and potential parents
def solve_problem_4(G, root):
    # Get the largest connected component
    largest_component = get_largest_component(G)

    # Set the root node as Gries
    root_node = root
    if root_node not in largest_component.nodes:
        root_node = list(largest_component.nodes)[0]
    
    # Generate BFS tree and calculate levels manually
    bfs_tree, levels = BFS_tree(largest_component, root_node)
    
    # Calculate the potential parents for each level
    potential_parents = calculate_potential_parents_bfs(largest_component, levels)
    
    # Add results for Problem 4(a)
    with open('hw1solution.txt', 'a') as f:
        for level, avg_parents in sorted(potential_parents.items()):
            f.write(f'@ 4 {level} {avg_parents}\n')

    # Construct the histogram for Problem 4(b)
    plot_potential_parents(potential_parents, 'plot4.pdf')

# BFS tree function
def BFS_tree(G, root_node):
    bfs_tree = {}  # To store the BFS tree structure
    levels = {root_node: 0}  # To store levels (distance from root)
    
    List = [root_node] # To store values
    # While there are nodes to explore
    while List:
        current_node = List.pop(0)  # Pop the first element, current_node is the parent of neighbor
        current_level = levels[current_node]

        # Iterate through neighbors of the current node
        for neighbor in G.neighbors(current_node):
            if neighbor not in levels: # Add neighbors
                levels[neighbor] = current_level + 1
                List.append(neighbor)

                # Add this node to the BFS tree 
                if current_node not in bfs_tree:
                    bfs_tree[current_node] = []
                bfs_tree[current_node].append(neighbor)
    return bfs_tree, levels

# Calculate potential parents for BFS levels
def calculate_potential_parents_bfs(G, levels):
    potential_parents = {}
    max_level = max(levels.values())

    # For each level starting from 1, level 0 is root
    for level in range(1, max_level + 1):
        nodes_at_level = [node for node, lvl in levels.items() if lvl == level]
        
        # Calculate the average number of potential parents for nodes at this level
        avg_parents = sum(len([nbr for nbr in G.neighbors(node) if levels.get(nbr, -1) == level - 1]) for node in nodes_at_level) / len(nodes_at_level) if nodes_at_level else 0
        potential_parents[level] = avg_parents
    return potential_parents


# Plot the average potential parents per level
def plot_potential_parents(potential_parents, filename):
    plt.figure()
    plt.bar(potential_parents.keys(), potential_parents.values())
    plt.xlabel('Level')
    plt.ylabel('Average Potential Parents')
    plt.title('Potential Parents per Level')
    plt.savefig(filename)

# Execute all tasks
def main():
    netid = "xc535"
    root = "Gries"
    data = load_and_filter_data('ps1data.txt')
    G = create_coauthorship_graph(data)
    
    # Solve all problems
    solve_problem_1(G, netid)
    solve_problem_2(G)
    solve_problem_3(G, root)
    solve_problem_4(G, root)

if __name__ == "__main__":
    main()
