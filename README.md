# Olist sales analysis

## Data Characteristics

### ZIP Codes (`customer_zip_code_prefix`)

The column is stored as `INTEGER`, so leading zeros are lost:
for example, `1151` instead of `01151`.

- **Reason:** Data type during import into SQLite.
- **Impact on the project:** None. Tables are not joined by ZIP
  code, so the analysis was not affected.
- **If you plan to use this column further** (geo-analysis, joining with a
  ZIP code reference table): convert it to text and pad with zeros to 5 digits.