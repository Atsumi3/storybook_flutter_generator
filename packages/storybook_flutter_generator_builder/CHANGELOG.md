# Changelog

## 0.2.0

- **Breaking Change**: Require Dart SDK `>=3.9.0 <4.0.0`
- **Breaking Change**: Update to analyzer `^8.0.0` (no longer compatible with analyzer 7.x or earlier)
- Fix: Update code for analyzer 8.x API changes
  - Replace `FunctionElement` with `TopLevelFunctionElement`
  - Add `languageVersion` parameter to `DartFormatter`
  - Update metadata access from `e.metadata` to `e.metadata.annotations`

## 0.1.0

- Initial release
