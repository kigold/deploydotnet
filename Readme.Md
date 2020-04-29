# Continuous Deployment of Dotnetcore app using PowerShell

This project is meant to get you started with a automated deployment.

You will be able to deploy your dotnetcore application in an automated fashion thereby leaving you with more time to focus on what you love doing ~~Cook beans~~ I mean write quality code.

I structued the script in a way that minimizes the need for you to update the main script itself.

### Preparations

> If you have not ran powershell scritps before you might need to do a bit of googling on how to run powershell scripts

You are required to do the following things

- Install Dotnet core SDK, as this is a requirement to build the project
- Create a folder to store the code that you want to deploy
- Create a folder to store the deployed code
- Create the web app with IIS (I hope you already know how to do this)

> For me, my code base contained different projects, so I had to create configurations for each application

What I expect you to do though, is to update the configuration file as required

- Create a configuration file for each project
  - This configuration file is an xml file
  - Give this file a simple name that you can use to define each application
    > Spoiler alert, the name you give this file is the argument that you would pass while running the script
  - Copy the xml in this project, and update the properties to suit your need
    - **codepath** this will be the path to the code you want to deploy
    - **deploypath** this is the folder path where you want to deploy the application
    - **appconfigpath** This is the folder path where you can place any file that you would like to use to replace files in you deployed app
    - **iisappname** This is the name of your web app on iis
    - **dotnetversion** This is the dotnetcore version you want to build with eg: netcoreapp2.2

### Run deployment

> We assume you have already pulled your updated code from you repository onto your local machine
> And you have cloned this project to have access to the files

- You need to run power shell in elevated mode, aka, run as Administrator
  - Click the window button
  - Type PowerShell
  - Right click on the PowerShell application that appears in the list
  - Select Run As Adminstrator
- Change Directory to the location of this project that you cloned
  - cd [path of project]
- Type

  ```
  .\deploy.ps1 -app [appname]

  ```

  - This is you running the script, and passing the name of the xml file you want to use to configure your deployment

  > I expect that your xml files are in the same folder as the **deploy.ps1** file
