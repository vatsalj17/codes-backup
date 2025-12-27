import pandas as pd
import requests
import json
import re
import time
from typing import Dict, Optional

# GraphQL endpoint and query
GRAPHQL_URL = "https://leetcode.com/graphql"
USER_QUERY = """
query getUserProfile($username: String!) {
  matchedUser(username: $username) {
    username
    submitStats: submitStatsGlobal {
      acSubmissionNum {
        difficulty
        count
      }
    }
  }
}
"""

def extract_username(profile: str) -> Optional[str]:
    """Extract LeetCode username from profile string (handles URLs, handles, etc.)."""
    if not profile or pd.isna(profile):
        return None
    profile_lower = profile.lower()
    if "leetcode" not in profile_lower:
        return None
    
    # Patterns: https://leetcode.com/u/username/, https://leetcode.com/username/, Leetcode - username, username
    patterns = [
        r'https?://leetcode\.com/u/([^/\s]+)',
        r'https?://leetcode\.com/([^/\s]+)',
        r'leetcode\s*[-_]\s*([a-zA-Z0-9_]+)',
        r'^([a-zA-Z0-9_]+)$'  # Just username
    ]
    
    for pattern in patterns:
        match = re.search(pattern, profile.strip())
        if match:
            return match.group(1).strip()
    return None

def get_solved_count(username: str) -> int:
    """Fetch solved count via GraphQL."""
    variables = {"username": username}
    response = requests.post(
        GRAPHQL_URL,
        json={"query": USER_QUERY, "variables": variables},
        headers={"Content-Type": "application/json", "User-Agent": "Mozilla/5.0"}
    )
    
    if response.status_code != 200:
        print(f"Error fetching {username}: HTTP {response.status_code}")
        return 0
    
    try:
        data = response.json()
        if "errors" in data:
            print(f"GraphQL error for {username}: {data['errors']}")
            return 0
        
        user_stats = data.get("data", {}).get("matchedUser", {})
        if not user_stats:
            print(f"User {username} not found or private.")
            return 0
        
        ac_stats = user_stats.get("submitStats", {}).get("acSubmissionNum", [])
        total_solved = 0
        for stat in ac_stats:
            total_solved += stat.get("count", 0)
        return total_solved
    except Exception as e:
        print(f"Parse error for {username}: {e}")
        return 0

def main(csv_file: str = "Women-Hiring-VSCode Test.csv", output_file: str = "candidates_solved_counts.csv"):
    # Read CSV (handle messy data)
    df = pd.read_csv(csv_file)
    # Assume columns: 0=Roll Number, 1=Profile, 2=Name (may be NaN)
    df.columns = ['roll_number', 'profile', 'name'] if len(df.columns) >= 3 else ['roll_number', 'profile']
    df = df.dropna(subset=['roll_number'])  # Drop empty rolls
    df = df.drop_duplicates(subset=['roll_number'])  # Dedup by roll
    
    results = []
    leetcode_count = 0
    
    for _, row in df.iterrows():
        username = extract_username(row['profile'])
        if username:
            leetcode_count += 1
            solved = get_solved_count(username)
            time.sleep(1.5)  # Rate limit delay
        else:
            solved = 0  # Non-LeetCode or invalid
        
        results.append({
            'roll_number': row['roll_number'],
            'name': row.get('name', 'N/A'),
            'leetcode_username': username or 'N/A',
            'solved_count': solved
        })
        print(f"Roll {row['roll_number']}: {username or 'No LeetCode'} -> {solved} solved")
    
    # Output to new CSV
    results_df = pd.DataFrame(results)
    results_df.to_csv(output_file, index=False)
    print(f"\nProcessed {len(results)} candidates ({leetcode_count} with LeetCode profiles).")
    print(f"Results saved to {output_file}")
    print(results_df[['roll_number', 'name', 'solved_count']].to_string(index=False))

if __name__ == "__main__":
    main()
