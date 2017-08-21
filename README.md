# ClickOnceSigning
ClickOnce signing for Visual Studio 2017

PowerShell script for signing ClickOnce applications with Code Signing Certificate.

The Script needs to be invoked using the following line in the ClickOnce applications csproj file.

    <Target Name="SignManifest" AfterTargets="_DeploymentSignClickOnceDeployment">
        <Exec Command="powershell -ExecutionPolicy Unrestricted 
        -command &quot;&amp; {$(SolutionDir)3rdParty\Signtool\ClickOnceSigning.ps1 
        -solutionDir '$(Solutiondir)' -publishDir '$(PublishDir)'}&quot;"
        -assemblyName 'Test' LogStandardErrorAsError="true" ContinueOnError="false" />
    </Target>
    
 The following needs to be changed for the script to work:
    -command &quot;&amp; {$(SolutionDir)3rdParty\Signtool\ClickOnceSigning.ps1
        Should be replaced with the location of the ClickOnceSigning powershell script.
    -assemblyName 'Test'
        Should be the assembly name of the ClickOnce application to sign. 
