import requests
import base64
from datetime import datetime

def fetch_repos(username="vatsalj17"):
    url = f"https://api.github.com/users/{username}/repos"
    
    # Optional: Add a User-Agent header (GitHub recommends this)
    headers = {
        "Accept": "application/vnd.github.v3+json",
        "User-Agent": "Python-Requests-Repo-Viewer"
    }
    
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Raises an HTTPError for bad responses
        repos = response.json()
        
        if not repos:
            print(f"No public repositories found for user: {username}")
            return
        
        print(f"Public repositories for GitHub user: {username}\n")
        print("=" * 80)
        
        for repo in repos:
            name = repo.get("name", "N/A")
            owner = repo["owner"].get("login", "N/A")
            description = repo.get("description") or "(No description)"
            created_at = repo.get("created_at", "")
            updated_at = repo.get("updated_at", "")
            
            # Format dates nicely
            if created_at:
                created = datetime.strptime(created_at, "%Y-%m-%dT%H:%M:%SZ").strftime("%B %d, %Y")
            else:
                created = "Unknown"
                
            if updated_at:
                updated = datetime.strptime(updated_at, "%Y-%m-%dT%H:%M:%SZ").strftime("%B %d, %Y")
            else:
                updated = "Unknown"
            
            print(f"Repository: {name}")
            print(f"Owner     : {owner}")
            print(f"Created   : {created}")
            print(f"Updated   : {updated}")
            print(f"Description: {description}")
            
            # Fetch and print README
            readme_url = f"https://api.github.com/repos/{owner}/{name}/readme"
            try:
                readme_response = requests.get(readme_url, headers=headers)
                if readme_response.status_code == 200:
                    readme_data = readme_response.json()
                    if readme_data.get('content'):
                        content = base64.b64decode(readme_data['content']).decode('utf-8')
                        print(f"\nREADME:\n{content.strip()}\n")
                    else:
                        print("\nREADME: (No content available)")
                elif readme_response.status_code == 404:
                    print("\nREADME: Not found")
                else:
                    print(f"\nREADME: Error fetching (status: {readme_response.status_code})")
            except Exception as readme_err:
                print(f"\nREADME: Error - {readme_err}")
            
            print("-" * 80)
            
    except requests.exceptions.HTTPError as http_err:
        print(f"HTTP error occurred: {http_err}")
        if response.status_code == 403:
            print("Rate limit exceeded or API access forbidden. Try again later.")
        elif response.status_code == 404:
            print(f"User '{username}' not found.")
    except requests.exceptions.RequestException as err:
        print(f"Error fetching data: {err}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    fetch_repos("vatsalj17")
