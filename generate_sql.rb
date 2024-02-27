require "yaml"

begin
    yaml_file_path = ARGV[0]
    data = YAML.load(File.read(yaml_file_path))
rescue =>e
    puts "[PROGRAM EXITED]"
    puts "Please give a yaml file path like\n\t$ruby test.rb ./data/dummy.yml"
    puts e.message
    exit
end


if !data.include?("Tables") or data["Tables"].empty?
    puts "Write tables info to insert columns"
    puts "Program ended without generating a sql file."
    exit
end

def new_column_data(column, index)
    "hoge"
end

def create_bulk_insert_sql(data, all_records, bulk_number)
    res = {}
    all_records.each do |table, records|
        columns = data["Tables"][table]["columns"].map(&:keys)
        sql_base = "INSERT INTO employees (#{columns.join(", ")})
        VALUES\n"
        cnt = 0
        sql_bulk_values = ""
        sqls = []
        records.each do |record|
            sql_bulk_values += "(#{record.join(", ")}),\n"
            cnt += 1
            if cnt == bulk_number
                cut = ",\n".length
                sql_bulk_values = sql_bulk_values[0...-cut] 
                # sql_bulk_values = sql_bulk_values.slice!(-3,3)
                new_sql = sql_base + sql_bulk_values + ";\n"
                sqls << new_sql
                # initialize
                sql_bulk_values = ""
                cnt = 0
            end
        end
        res[table] = sqls
    end

    res
end

bulk_number = data["bulk_insert"]
all_records = {}
data["Tables"].each do |table_name, table_info|
    column_count = table_info["count"]
    column_info = table_info["columns"]

    column_names = column_info.map(&:keys)
    records = []
    0.upto(column_count-1) do |index|
        new_record = []
        column_names.each do |column|
            new_record << (new_column_data(column, index))
        end
        records << new_record
    end
    all_records[table_name] = records
end

sql_commands_hash = create_bulk_insert_sql(data, all_records, bulk_number)

#generate a file
File.open("./generated_sql/result#{Time.now}.sql", "w") do |file|
    sql_commands_hash.each do |table, commands|
        file.puts %Q!--insert for table "#{table}"!
        file.puts commands
    end
  end