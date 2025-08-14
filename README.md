rebar3_erlydtl_plugin
=====

The `rebar_erlydtl_plugin` module is a plugin for Rebar3 that compiles
ErlyDTL templates.  By default, it compiles all priv/templates/*.dtl
to ebin/*_dtl.beam.

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    {plugins, [
        {rebar3_erlydtl_plugin, ".*", {git, "https://github.com/erlydtl/rebar3_erlydtl_plugin.git", {branch, "master"}}}
    ]}.

Then just call your plugin directly in an existing application:


    $ rebar3 erlydtl compile
    ===> Fetching rebar3_erlydtl_plugin
    ===> Compiling rebar3_erlydtl_plugin

To have it invoked automatically when running `rebar3 compile` add it as a `provider_hooks`:

```
{provider_hooks, [
                 {pre, [{compile, {erlydtl, compile}}]}
                 ]}.
```

Configuration options should be placed in rebar.config under
'erlydtl_opts'.  It can be a list of name-value tuples or a list of
lists of name-value tuples if you have multiple template directories
that need to have different settings (see example below).

Available options include:

- `doc_root`: Where to find templates to compile.
    `"priv/templates"` by default.
- `out_dir`: Where to put compiled template beam files.
    `"ebin"` by default.
- `source_ext`: The file extension the template sources have.
    `".dtl"` by default.
- `module_ext`: Characters to append to the template's module name.
    `"_dtl"` by default.
- `recursive`: Boolean that determines if `doc_root` directories need to be
  scanned recursively for matching template file names. Default: `true`.
  For example, if you had:
  ```
      /t_src/
          base.html
          foo.html
  ```
  And you wanted them compiled to:
  ```
      /priv/
          base.beam
          foo.beam
  ```
  You would add to your rebar.config:
  ```
      {erlydtl_opts, [
        {doc_root,   "t_src"},
        {out_dir,    "priv"},
        {source_ext, ".html"},
        {module_ext, ""}
       ]}.
  ```
  The default settings are the equivalent of:
  ```
      {erlydtl_opts, [
        {doc_root,   "priv/templates"},
        {out_dir,    "ebin"},
        {source_ext, ".dtl"},
        {module_ext, "_dtl"}
       ]}.
  ```

The following example will compile the following templates:
`"src/*.dtl"` files into `"ebin/*_dtl.beam"`, and
`"priv/templates/*.html"` into `"ebin/*.beam"`. Note that any tuple option
such as `out_dir` in the outer list will be added to each inner list:
```
    {erlydtl_opts, [
      {out_dir, "ebin"},
      {recursive, false},
      [
       {doc_root, "src"},
       {module_ext, "_dtl"}
      ],
      [
       {doc_root, "priv/templates"},
       {module_ext, ""},
       {source_ext, ".html"}
      ]
    ]}.
```
