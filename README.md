# go.opentelemetry.io
Vanityurls config for go.opentelemetry.io subdomain

## Architecture

The Hugo build is organized around a lightweight template that renders each
vanity path into a small HTML document containing the metadata used by the `go`
toolchain.

### Structure

```
/
├── content/
│   └── packages/PACKAGE_NAME.md
├── themes/default
│   └── layouts/_default/single.html
└── config.toml
└── netlify.toml
```

### How it works

1. **Each module or submodule is represented as a page** in the `content/packages`
	 directory.
2. Each page contains front matter defining:

	* The path to the repo this module is in.
3. A single Hugo template (`themes/default/layouts/_default/single.html`) renders the page into
	 the minimal HTML required for Go module resolution.
4. The result is a fully static directory structure like:

	 ```
	 public/packages/
	 ├── otel/index.html
	 ```

### Redirects

To handle sumodules, we rely on Netlify's redirect feature.
In `netlify.toml`, we instruct to:

* Redirect `/:name` to `/packages/:name`, for each root package.
* Redirect `/:name/*` to `/packages/:name`, for each submodule.

### Meta Tags

We use Go's [Remote Import
Paths](https://pkg.go.dev/cmd/go#hdr-Remote_import_paths) to properly get Go to
redirect from the canonical URL to its repository.
Each vanity HTML page contains:

#### go-import

```
<meta name="go-import" content="go.opentelemetry.io/otel git https://github.com/open-telemetry/opentelemetry-go">
```

This instructs the Go toolchain to fetch the module from GitHub using Git.

#### go-source

```
<meta name="go-source" content="go.opentelemetry.io/otel https://github.com/open-telemetry/opentelemetry-go https://github.com/open-telemetry/opentelemetry-go/tree/main{/dir} https://github.com/open-telemetry/opentelemetry-go/blob/main{/dir}/{file}#L{line}">
```

These tags are derived from the front matter of each module's content file.

### Homepage

The homepage automatically lists all main modules the app handles.

```
/
├── content/
│   └── _index.md
├── layouts/shortcodes
│   └── package-list.html
```

The `package-list` shortcode generates the list of packages, and is used with
the Hugo DSL within the `_index.md` page.

## Adding a new package

Packages are configured in the `content/packages` folder. Each of them has a
content file with the package name.

Create a new file in `content/packages/<YOUR PACKAGE NAME>.md`. For example,
`content/packages/my_package.md`.

Add the following header to the document:

```markdown
---
repo: URL TO THE REPOSITORY
---
```

Where the URL to the repository is the location of the source code you need the
package to point to.
