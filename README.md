# ClickOnceSigning
ClickOnce signing for Visual Studio 2017

PowerShell script for signing ClickOnce applications with Codesigning Certificate.

The Script needs to be invoked using the following line in the ClickOnce applications csproj file.

    <Target Name="SignManifest" AfterTargets="_DeploymentSignClickOnceDeployment">
        <Exec Command="powershell -ExecutionPolicy Unrestricted 
        -command &quot;&amp; {$(SolutionDir)3rdParty\Signtool\ClickOnceSigning.ps1 
        -solutionDir '$(Solutiondir)' -publishDir '$(PublishDir)'}&quot;"
        -assemblyName 'Test' LogStandardErrorAsError="true" ContinueOnError="false" />
    </Target>
    
 The following needs to be changed for the script to work:
 + -command &quot;&amp; {$(SolutionDir)3rdParty\Signtool\ClickOnceSigning.ps1
    * Should be replaced with the location of the ClickOnceSigning powershell script.
 + -assemblyName 'Test'
   * Should be the assembly name of the ClickOnce application to sign. 
   
 In the Powershell script the following needs to be changed:
 + $sha1 = Get-ChildItem -Path Cert:\CurrentUser\My -Recurse |  where {$_.Subject -like '*Company*'} | Select-Object -First 1
   * Change Company(keeping the asterixs) to something unique from the subject of your codesigning certificate.
 + Change occurrences of "Company Name" to the name of publisher
