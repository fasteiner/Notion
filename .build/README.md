# Custom task directory

If you need custom tasks (e.g. custom sidebar generation) then this folder holds the functions.

How to get it work?

* Add a function to ./build directory
* Add a task in ./build.ps1 which calls the function(s) ( ~ line 328 or search for '# Synopsis: Empty task, useful to test the bootstrap process.')
* Configure the task in ./build.yaml

## Changes to build.ps1

```powershell
task Your_custom_task {
    $functionParams = @{
        Parameter1 = "value1"
        Parameter2 = "value2"
    }
    New-CustomFunction @functionParams
    Get-Error | Out-String | Write-Host -ForegroundColor Yellow
}
```

## Changes to build.yaml

```yaml
build:
    - Clean
    - Build_Module_ModuleBuilder
    - Build_NestedModules_ModuleBuilder
    - Create_changelog_release_output
    - Generate_MAML_from_built_module
    - Your_custom_task

custom_workflow:
    - Your_custom_task
 ```

## Executing build workflows

A collection of tasks is called a workflow. A few default workflows are provided in the `build.yaml` file. You can execute a workflow by specifying the name of the workflow in the `-Tasks` parameter. It is also possible to define your own workflows, in the `build.yaml` file, and execute them in the same way.

```powershell
./build.ps1 -Tasks build
# or
./build.ps1 -Tasks custom_workflow

# or
./build.ps1 -Tasks Your_custom_task, build
```

## Exexcuting custom tasks alone

```powershell
./build.ps1 -Tasks Your_custom_task
```
