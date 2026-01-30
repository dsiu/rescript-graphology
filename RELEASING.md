# Releasing

This document describes how to release new versions of `@dsiu/rescript-graphology`.

## Prerequisites

- You must be logged in to npm: `npm whoami`
- You must have publish access to the `@dsiu` scope on npm

## One-Time Setup: Trusted Publishing

This package uses [npm Trusted Publishing](https://docs.npmjs.com/generating-provenance-statements) with GitHub Actions OIDC. This eliminates the need for npm tokens stored as secrets.

### Configure Trusted Publishing on npmjs.com

1. Go to [npmjs.com](https://www.npmjs.com) and log in
2. Navigate to your package: `@dsiu/rescript-graphology`
3. Go to **Settings** > **Publishing access**
4. Under **Trusted Publishing**, click **Add a trusted publisher**
5. Configure:
   - **Repository owner**: `dsiu`
   - **Repository name**: `rescript-graphology`
   - **Workflow filename**: `publish.yml`
   - **Environment**: (leave blank)
6. Click **Add**

> **Note**: You must publish the package manually at least once before you can configure Trusted Publishing.

## Release Process

### 1. Update Version

```bash
# Update version in package.json
npm version patch  # or minor, major
```

This will:
- Update `package.json` version
- Create a git commit
- Create a git tag

### 2. Push Changes and Tag

```bash
git push origin main --tags
```

### 3. Create GitHub Release

```bash
# Create a release (this triggers the publish workflow)
gh release create v0.1.0 --title "v0.1.0" --notes "See CHANGELOG.md for details"
```

Or create the release via GitHub UI:
1. Go to **Releases** > **Create a new release**
2. Choose the tag you just pushed
3. Add release title and notes
4. Click **Publish release**

The `publish.yml` workflow will automatically:
- Run tests
- Publish to npm with provenance

## First-Time Manual Publish

For the very first publish (before Trusted Publishing is configured):

```bash
# Ensure you're logged in
npm whoami

# Build and test
yarn clean && yarn build && yarn test

# Publish (first time only)
npm publish --access public
```

After the first publish, configure Trusted Publishing as described above.

## Manual Publishing (Fallback)

If you need to publish manually (e.g., Trusted Publishing issues):

```bash
# Login to npm
npm login

# Build and test
yarn clean && yarn build && yarn test

# Publish
npm publish --access public
```

## Verifying the Release

After publishing:

1. Check npm: `npm view @dsiu/rescript-graphology`
2. Verify provenance badge on npmjs.com package page
3. Test installation in a new project:
   ```bash
   mkdir test-install && cd test-install
   npm init -y
   npm install @dsiu/rescript-graphology
   ```

## Version Guidelines

- **Patch** (0.0.x): Bug fixes, documentation updates
- **Minor** (0.x.0): New features, non-breaking changes
- **Major** (x.0.0): Breaking changes

For pre-1.0 releases, minor versions may include breaking changes.
