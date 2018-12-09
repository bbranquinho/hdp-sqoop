# hdp-sqoop

```bash
sqoop import -Dorg.apache.sqoop.splitter.allow_text_splitter=true \
  --connect jdbc:postgresql://localhost:5432/database?currentSchema=schema \
  --username user \
  --password pass \
  --table table \
  --map-column-java custom_fields=String \
  --target-dir /user/branquinho/teste
```
