# ClickOnceSigning
ClickOnce signing for Visual Studio 2017


    <Target Name="SignManifest" AfterTargets="_DeploymentSignClickOnceDeployment">
        <Exec Command="powershell -ExecutionPolicy Unrestricted -command &quot;&amp; 
        {$(SolutionDir)3rdParty\Signtool\ClickOnceSigning.ps1 -solutionDir '$(Solutiondir)' -publishDir '$(PublishDir)'}&quot;"
        LogStandardErrorAsError="true" ContinueOnError="false" />
    </Target>
