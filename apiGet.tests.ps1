#apiGet.tests.ps1
#Pre: URI https://andruxnet-random-famous-quotes.p.mashape.com/ exists
#Key Value pair must be in source command header
#Programmer: Amiyn al-Ansare
#21 February, 2019

#$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
#& $scriptDir\apiGet.ps1
$h = @{}
$h.add("X-Mashape-Key",'bckcFeIRo5mshMpc3C4ug7tmUplYp1jYdDYjsnBy5UQQpYB6dE')
try 
{
    $data = Invoke-RestMethod -Uri https://andruxnet-random-famous-quotes.p.mashape.com/ -ContentType JSON -Headers $h -Method Get
}
Catch
{    
    Write-Host -ForegroundColor Red "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host -ForegroundColor Red "StatusDescription:" $_.Exception.Response.StatusDescription
    if ($_.ErrorDetails.Message -ne $null)
    {
        $e = $_.ErrorDetails.Message | ConvertFrom-Json | Select-Object -Expand message
        throw $e 
    }
}
#Testing for "quotes"
Describe "Test for empty quotes"{
    $quote = $data.quote
    Write-Host $quote 
    It "Quote Should not be NULL"{
        $quote | Should not be $null
    }
}

Describe "Test for empty authors"{
    $author = $data.author
    Write-Host $author
    It "Author Should not be NULL"{
        $author | Should not be $null
    }
}

Describe "Test for empty categories"{
    $category = $data.category
    Write-Host $category
    It "Category Should not be NULL"{
        $category | Should not be $null
    }
}
