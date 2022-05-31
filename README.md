# Lab registrion system
Lab registrion system is an application that provide schedules registration feature for lecturers by selecting week or import excel file. Especially, it also support lab managers for schedule by “Genetic Algorithm”. 

## Installation
### Clone project
```bash
git clone https://github.com/lhduc2205/LabRegistrationSystem.git
```
<br/>

### Database
You must download [pgAdmin4](https://www.pgadmin.org/download/ "pgAdmin4 Home") because this system use PostgreSQL.

Create username and password to login pgAdmin4.

Create database has name is **LabRegistrationSystem**.
<br/>



### API
> Make sure current path is `<your_achive_folder>/LabRegistrationSystem>`.

* **Server**

    Move to API folder in terminal
    ```bash
    cd ./api
    ```
    Generate node_modules folder
    ```bash
    npm i
    ```
    Run api
    ```bash
    npm run dev
    ```
    <br/>

* **Database**

    Move to db folder in terminal
    ```bash
    cd ./db
    ```

    To connect with your DB, you will change some value at knexfile.js

    ```JavaScript
    connection: {
        database: 'LabRegistrationSystem',
        user: <your_username>,
        password: <your_password>,
        ...
    },
    ```

    Create migrations
    ```bash
    npm run migration
    ```
    Create seeds
    ```bash
    npm run seed
    ```
    
    <br/>

### Front-end
> Make sure current path is `<your_achive_folder>/LabRegistrationSystem>`.

Move to front-end folder in terminal
```bash
cd ./front-end
```
Generate pubspec.lock file
```bash
flutter pub get
```
Run client
```bash
flutter run
```
