import pandas as pd
import requests
import re
import time

# Regex to extract LeetCode username from various URL formats
# Matches: leetcode.com/u/username or leetcode.com/username
LC_REGEX = r"leetcode\.com/(?:u/)?([a-zA-Z0-9_-]+)"

def get_leetcode_solved(username):
    """Fetches total solved count using LeetCode's GraphQL API."""
    url = "https://leetcode.com/graphql"
    query = {
        "query": """
        query userProblemsSolved($username: String!) {
            matchedUser(username: $username) {
                submitStats {
                    acSubmissionNum {
                        difficulty
                        count
                    }
                }
            }
        }
        """,
        "variables": {"username": username}
    }
    
    headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0',
        'Content-Type': 'application/json',
    }

    try:
        response = requests.post(url, json=query, headers=headers, timeout=10)
        if response.status_code == 200:
            data = response.json()
            if data.get('data') and data['data']['matchedUser']:
                # Index 0 is 'All' difficulty
                return data['data']['matchedUser']['submitStats']['acSubmissionNum'][0]['count']
        return "Not Found"
    except Exception as e:
        return f"Error: {str(e)}"

def process_csv(file_path):
    df = pd.read_csv(file_path)
    # Filter out rows without links
    df = df.dropna(subset=['Paste your online coding profile'])
    
    results = []
    
    print(f"Starting fetch for {len(df)} records...")
    
    for index, row in df.iterrows():
        profile_url = str(row['Paste your online coding profile'])
        roll_no = row['Roll Number']
        
        # Extract username
        match = re.search(LC_REGEX, profile_url)
        if match:
            username = match.group(1)
            print(f"[{index}] Fetching for {username}...", end="\r")
            solved = get_leetcode_solved(username)
            results.append({'Roll Number': roll_no, 'Username': username, 'Solved': solved})
            # Be a good net citizen: don't spam the API too fast
            time.sleep(0.5) 
        else:
            results.append({'Roll Number': roll_no, 'Username': 'N/A', 'Solved': 'No LC Link'})

    output_df = pd.DataFrame(results)
    output_df.to_csv('coding_stats_results.csv', index=False)
    print("\nProcessing complete! Data saved to coding_stats_results.csv")

if __name__ == "__main__":
    # Ensure you have 'requests' and 'pandas' installed via pacman or pip
    process_csv('Women-Hiring-VSCode Test.csv')
