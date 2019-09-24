# Clean

Cleans up after Copado.

# Criteria for removal

There are two criterial for removal, one of which can be removed all together

1. The branch has not been committed to in 4 months
  - A log of a branche's commit history can be found with `git log $branch --since "4 months ago"`
  - The count of a branche's commit history can be found with `git log $branch --since "4 months ago" | wc -l`
2. The branches that have already been merged into the master branch (and may be stale)
  - These can be found with `git branch -r --merged`
  - This criteria can be disabled with the `soft` argument, and enabled with the `hard` argument

# Usage

1. Clone the repository that you would like to clean
```
// ssh
git clone git@github.com:your_repo.git
// https
https://github.com/your_repo.git
```
2. Navigate to your repo
```
cd your_repo
```
3. Fetch all the remote branches
```
git fetch -a
```
4. Ensure you are on the `master` branch
```
git checkout master
```
5. Run your command either as a dry run for testing or as a wet run

## Dry Run
  
A soft run means that we do not remove branches that have been merged into master (or branches that could be stale)
  
From within your repository, run the `clean.sh` script using the `testme` and `soft` arguments for a soft dry run and the `testme` and `hard` arguments for a hard dry run.
  
```
// soft dry run
path/to/the/script testme soft

// hard dry run
path/to/the/script testme hard
```

## Wet Run

From within your repository, run the `clean.sh` script using the `dome` and `soft` arguments for a soft dry run and the `dome` and `hard` arguments for a hard dry run.

```
// soft wet run
path/to/the/script dome soft

// hard wet run
path/to/the/script dome hard
```

# Example Outputs

```
> ../clean testme soft

💩  promotion/P0xxxx-DeployP0xxxxBranchName
git branch -d promotion/P0xxxx-DeployP0xxxxBranchName
git push origin --delete promotion/P0xxxx-DeployP0xxxxBranchName

💀  promotion/P0yyyy-DeployP0yyyyBranchName
git branch -d promotion/P0yyyy-DeployP0yyyyBranchName
git push origin --delete promotion/P0yyyy-DeployP0yyyyBranchName

Promotion branches deleted: 2

🔫  feature/US-000xxxx
git branch -d feature/US-000xxxx
git push origin --delete feature/US-000xxxx

💣  feature/US-000yyyy
git branch -d feature/US-000yyyy
git push origin --delete feature/US-000yyyy

Feature branches deleted: 2

Total branches deleted: 4
```

```
> ../clean testme hard

💅  promotion/P0xxxx-DeployP0xxxxBranchName
git branch -d promotion/P0xxxx-DeployP0xxxxBranchName
git push origin --delete promotion/P0xxxx-DeployP0xxxxBranchName

🙌  promotion/P0yyyy-DeployP0yyyyBranchName
git branch -d promotion/P0yyyy-DeployP0yyyyBranchName
git push origin --delete promotion/P0yyyy-DeployP0yyyyBranchName

Promotion branches deleted: 2

⏰  feature/US-000xxxx
git branch -d feature/US-000xxxx
git push origin --delete feature/US-000xxxx

🔥  feature/US-000yyyy
git branch -d feature/US-000yyyy
git push origin --delete feature/US-000yyyy

Feature branches deleted: 2

Total branches deleted: 4

Stale branches deleted: 38

```
