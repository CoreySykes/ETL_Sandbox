# Auto-Generating Server Logs

### Overview

This repository contains some code generation to auto-generate Apache logs, parse them, and store them in a local MySQL instance. This simulates situations where there are real live streaming server logs for analytics use cases.

### How To Use (Code Conversion)

You must have the following applications installed in order to run the project in isolation:

* **Tools**:
    * Python
    * XAMPP (MySQL Instance needed)
    * Some Unix-CLI type tool (I prefer Git Bash)

Assuming you have these tools, you can clone the repository down and run the following steps:

1. Start XAMPP (Apache and MySQL) and run the below code snippet to build the streaming log table.

```
python init/000_Log_Table_Creation_ddl.py
```

2. Run the below code snippet to begin generating logs

```
cd main/
nohup sh 100_Execute_Log_Generator.sh --number_of_iterations=[number] &
```

e.g. This will create rows of data every few seconds for 100 iterations.

```
cd main/
nohup sh 100_Execute_Log_Generator.sh --number_of_iterations=100 &
```

3. Open up your MySQL db to see the data streaming in. Normally it's located here: http://localhost/phpmyadmin/

<img src="https://i.imgur.com/53HZDq8.png" style="width:50%;height=50%"></img>