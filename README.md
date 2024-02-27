# ruby-scriting-challenge

## YAML format
### yaml_format
- tables - table - count  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- column
- bulk_insert_num 
 
 
### column_format 
name type option  
(ex. id integer sequential) 

### options

## How to use
1. Make a yaml file
2. Execute a "test.rb" file with a file path (command-line arguments)  
    ex. ruby test.rb ./data/dummy.yml
3. The generated sql file can be seen under the generated_sql directory