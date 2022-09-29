

<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜 
#̷𝓍   
#̷𝓍   Write-LogEntry
#̷𝓍   
#>




    function Show-DebugDisplayDialog([string]$Message, [string]$WindowTitle, [string]$DefaultText){
        Add-Type –AssemblyName System.Drawing
        Add-Type –AssemblyName System.Windows.Forms
     
        # Create the Label.
        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Size(10,10) 
        $label.Size = New-Object System.Drawing.Size(280,20)
        $label.AutoSize = $true
        $label.Text = $Message
     
        # Create the TextBox used to capture the user's text.
        $textBox = New-Object System.Windows.Forms.TextBox 
        $textBox.Location = New-Object System.Drawing.Size(10,40) 
        $textBox.Size = New-Object System.Drawing.Size(575,200)
        $textBox.AcceptsReturn = $true
        $textBox.AcceptsTab = $false
        $textBox.Multiline = $true
        $textBox.ScrollBars = 'Both'
        $textBox.Text = $DefaultText
     
        # Create the OK button.
        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Size(415,250)
        $okButton.Size = New-Object System.Drawing.Size(75,25)
        $okButton.Text = "OK"
        $okButton.Add_Click({ $form.Tag = $textBox.Text; $form.Close() })
     
        # Create the Cancel button.
        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Size(510,250)
        $cancelButton.Size = New-Object System.Drawing.Size(75,25)
        $cancelButton.Text = "Cancel"
        $cancelButton.Add_Click({ $form.Tag = $null; $form.Close() })
     
        # Create the form.
        $form = New-Object System.Windows.Forms.Form 
        $form.Text = $WindowTitle
        $form.Size = New-Object System.Drawing.Size(610,320)
        $form.FormBorderStyle = 'FixedSingle'
        $form.StartPosition = "CenterScreen"
        $form.AutoSizeMode = 'GrowAndShrink'
        $form.Topmost = $True
        $form.AcceptButton = $okButton
        $form.CancelButton = $cancelButton
        $form.ShowInTaskbar = $true
     
        # Add all of the controls to the form.
        $form.Controls.Add($label)
        $form.Controls.Add($textBox)
        $form.Controls.Add($okButton)
        $form.Controls.Add($cancelButton)
     
        # Initialize and show the form.
        $form.Add_Shown({$form.Activate()})
        $form.ShowDialog() > $null   # Trash the text of the button that was clicked.
     
        # Return the text that the user entered.
        return $form.Tag
    }





function New-SimpleEntryForm
{
    [CmdletBinding()]
    Param
    ()
    try {

        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $form = New-Object System.Windows.Forms.Form
        $form.Text = 'Data Entry Form'
        $form.Size = New-Object System.Drawing.Size(300,200)
        $form.StartPosition = 'CenterScreen'

        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(75,120)
        $okButton.Size = New-Object System.Drawing.Size(75,23)
        $okButton.Text = 'OK'
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $okButton
        $form.Controls.Add($okButton)

        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Point(150,120)
        $cancelButton.Size = New-Object System.Drawing.Size(75,23)
        $cancelButton.Text = 'Cancel'
        $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $cancelButton
        $form.Controls.Add($cancelButton)

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10,20)
        $label.Size = New-Object System.Drawing.Size(280,20)
        $label.Text = 'Please enter the information in the space below:'
        $form.Controls.Add($label)

        $textBox = New-Object System.Windows.Forms.TextBox
        $textBox.Location = New-Object System.Drawing.Point(10,40)
        $textBox.Size = New-Object System.Drawing.Size(260,20)
        $form.Controls.Add($textBox)

        $form.Topmost = $true

        $form.Add_Shown({$textBox.Select()})
        $result = $form.ShowDialog()

        if ($result -eq [System.Windows.Forms.DialogResult]::OK)
        {
            $x = $textBox.Text
            $x
        }

    }catch{

        Write-Error $_
    }
}


Function New-SimpleGUIForm{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string]$FormTitleText,
        [Parameter(Mandatory=$false)]
        [int]$FormWidth,
        [Parameter(Mandatory=$false)]
        [int]$FormHeight,
        [Parameter(Mandatory=$false)]
        [string[]]$Fieldnames,
        [Parameter(Mandatory=$false)]
        [string]$fontName,
        [Parameter(Mandatory=$false)]
        [int]$fontsize,
        [Parameter(Mandatory=$false)]
        [int]$labelxlocation,
        [Parameter(Mandatory=$false)]
        [int]$labelyspacing,
        [Parameter(Mandatory=$false)]
        [int]$textboxxlocation,
        [Parameter(Mandatory=$false)]
        [int]$textboxyspacing,
        [Parameter(Mandatory=$false)]
        [int]$labelheight,
        [Parameter(Mandatory=$false)]
        [int]$labelwidth,
        [Parameter(Mandatory=$false)]
        [int]$TextboxHeight,
        [Parameter(Mandatory=$false)]
        [int]$TextboxWidth,
        [Parameter(Mandatory=$false)]
        [string]$ButtonText,
        [Parameter(Mandatory=$false)]
        [int]$ButtonHeight,
        [Parameter(Mandatory=$false)]
        [int]$ButtonWidth
    )

    try{

        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $form = New-Object System.Windows.Forms.Form
        $form.Text = 'Data Entry Form'
        $form.Size = New-Object System.Drawing.Size($FormHeight,$FormWidth)
        $form.StartPosition = 'CenterScreen'



        <#
        This GUI includes only simple checkboxes. More advanced things are possible, but this is beyond the purpose of the script. 
        To get inspiration/help building a GUI with other things like dropdownboxes, checkboxes, etc. take a look at https://poshgui.com 
        
        Also keep in mind that when you leave a field empty, it is an empty string and not a $NULL value. Either convert it to a $NULL value later on or modify the functions you use the GUI for.
        #>

        $i = 0
        $TextboxVariables = @()

        #region Create and configure form
        Add-Type -AssemblyName System.Windows.Forms
        $Form = New-Object system.Windows.Forms.Form 
        $Form.Text = $Formtitletext
        $Form.TopMost = $true
        $Form.Width = $FormWidth
        $Form.Height = $FormHeight
        #endregion Create and configure form"

        Foreach($item in $Fieldnames)
        {
            $NameWithoutSpaces = $item.replace(' ','')

            #Create and configure Label
            $LabelYLocation = (($i+1)*$labelyspacing)
            $Label = New-Object system.windows.Forms.Label
            $Label.Text = $item
            $Label.Width = $labelwidth
            $Label.Height = $labelheight
            $Label.Location = new-object system.drawing.point($labelxlocation,$LabelYLocation)
            #[System.Drawing.FontFamily]$fontFam = [System.Drawing.FontFamily]::new($FontName)
            #[System.Drawing.Font]$labelFont = [System.Drawing.Font]::new($fontFam,$FontSize)
            #$Label.Font = "Comic Sans MS,8.25"
            $Form.Controls.Add($Label)
            Remove-Variable -Name 'Label'

            #Create and configure Textbox
            $TextBoxVariableName = "Textbox_$NameWithoutSpaces"
            $TextboxVariables += $TextBoxVariableName
            $TextboxYLocation = (($i+1)*$textboxyspacing)
            $Textbox = New-Variable -Name $TextBoxVariableName
            $Textbox = New-Object system.windows.Forms.Textbox
            $Textbox.name = $TextBoxVariableName
            $Textbox.Width = $TextboxWidth
            $Textbox.Height = $TextboxHeight
            $Textbox.Location = new-object system.drawing.point($textboxxlocation,$TextboxYLocation)
            #[System.Drawing.FontFamily]$fontFam = [System.Drawing.FontFamily]::new($FontName)
            #[System.Drawing.Font]$textBoxFont = [System.Drawing.Font]::new($fontFam,$FontSize)
            #$Textbox.Font = "Comic Sans MS,8.25"
            $Textbox.TabIndex = $i
            $Form.Controls.Add($Textbox)

            $i++
        }

        #region Create and configure button and actions when clicked

        $ButtonYlocation = (($i+1) *$textboxyspacing)
        $FormButton = New-Object system.windows.Forms.Button 
        $FormButton.Text = $ButtonText
        $FormButton.Width = $ButtonWidth
        $FormButton.Height = $ButtonHeight
        $FormButton.location = new-object system.drawing.point($textboxxlocation,$ButtonYlocation)

        #[System.Drawing.FontFamily]$fontFam = [System.Drawing.FontFamily]::new($FontName)
        #[System.Drawing.Font]$formFont = [System.Drawing.Font]::new($fontFam,$FontSize,[System.Drawing.FontStyle]::Bold)
        #$FormButton.Font = "Comic Sans MS,8.25"
        $FormButton.tabindex = $i
        $FormButton.Add_Click({ 
            #add here code triggered by the event
            $Form.Close()
        })
        $Form.controls.Add($FormButton)
        Remove-Variable -Name 'FormButton'

        #Show the form
        [void]$Form.ShowDialog()
        
        #Get the names and values of the Textbox controls, store these in a hashtable and output it.
        #The array output is converted to a hashtable to make it more easily accessible.
        $Output = @{}
        $Form.controls | Where-Object{$_.name -match 'Textbox_'} | ForEach-Object{$Output.Add($_.name,$_.text)}  
        $Output
    }catch{

       Show-ExceptionDetails $_ -ShowStack
    }
}




function Test-NewGuiSample{
    [CmdletBinding()]
    Param
    ()
    try {

        #region example

        #Define the parameters the function will be run with. In most cases it's sufficient to modify FormTitleText,FieldNames,ButtonText.
        $Parameters = @{
            FormTitleText = 'Create new user'
            FieldNames = @('FirstName','LastName','ReferenceUser')
            ButtonText = 'OK'
            FormWidth = 666
            FormHeight = 666
            FontName = 'Microsoft Sans Serif'
            FontSize = 12
            labelxlocation = 25
            textboxxlocation = 380
            labelyspacing = 40
            textboxyspacing = 40
            labelheight = 20
            LabelWidth = 280
            TextboxHeight = 20
            TextboxWidth = 250
            ButtonHeight = 75
            ButtonWidth = 250
        }

        #Run the function with the defined parameters and store the result in the $result parameter
        New-SimpleGUIForm @Parameters

        #Show all texboxes and their values
        $Result 

        #Get the value of specific textboxes, optionally convert an empty string to $NULL and store the result in a variable to be used later on.
        IF($Result.Textbox_FirstName -eq ''){$Firstname = $NULL}ELSE{$Firstname = $Result.textbox_Firstname}
        IF($Result.Textbox_LastName -eq ''){$Lastname = $NULL}ELSE{$Lastname = $Result.textbox_Lastname}
        IF($Result.Textbox_ReferenceUser -eq ''){$ReferenceUser = $NULL}ELSE{$ReferenceUser = $Result.Textbox_ReferenceUser}

        #Optionally verify the values
        Write-Output "First name value is : $Firstname"
        Write-Output "Last name value is : $Lastname"
        Write-Output "Reference user value is : $ReferenceUser"
        Write-Output "Reference user value is `$NULL value : $($ReferenceUser -eq $NULL)" #Check if $NULL value
        Write-Output "Reference user value is empty string : $($ReferenceUser -eq '')" #Check if empty string

        #Use the values for your own functions.
        #New-BHUser -Firstname $Firstname -Lastname $Lastname -ReferenceUser $ReferenceUser

        #endregion example 
    }catch{

       Show-ExceptionDetails $_ -ShowStack
    }
}


