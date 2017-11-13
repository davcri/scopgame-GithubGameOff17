# How to contribute

### Branches
- `features/<feature_name>`: branch for the development of a certain feature.
When the work is completed, the branch should be merged into `develop`
- `develop`: branch for general development and fixes
- `master`: stable branch where the code is merged from `develop`. Commit should
be tagged when merging from `develop`

### Tip: rebase to avoid conflicts
When you are working on a feature branch, remember to rebase often on develop:
```
git checkout features/my_feat
git rebase develop
```
In this way we can avoid large pull requests (and avoid conflicts).

If there are conflicts and you don't want to resolve them, you can abort the rebase:
```
git rebase --abort
```
