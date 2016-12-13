# Setup the correct modules for SharePoint Manipulation 
if ( (Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null ) 
{     
   Add-PsSnapin Microsoft.SharePoint.PowerShell 
} 
$host.Runspace.ThreadOptions = "ReuseThread"

#Load CSV
$delimeter =','
$csvdata = Import-Csv -Path C:\Scripts\Buyers.csv -Delimiter $delimeter

#Site
$webURL = "http://sharepoint.totaltool.int/sales"
#List
$listname ="Stocking Vendors"

#Sharepoint Column Names
$buyer = "Buyer"
$buyerInfo = "BuyerInfo"

#Get Sharepoint site
$web = Get-SPWeb $webURL
#Get List and Items
$list = $web.Lists[$listname]
$items = $list.Items

foreach ($line in $csvdata){
    foreach($item in $items){
        if($item[$buyer] -eq $line.'Buyer'){
            $item[$buyerInfo] = $line.BuyerInfo
            $item.Update();
        }
    }
}
$list.update()



