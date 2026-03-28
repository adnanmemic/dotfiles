# Prompt
oh-my-posh init pwsh --config 'C:\Users\adnan\AppData\Local\Programs\oh-my-posh\themes\jblab_2021.omp.json' | Invoke-Expression

# load icons
Import-Module -Name Terminal-Icons

# functions
function backup_config {
	py $env:USERPROFILE\configFiles\backup-config-skript.py
}

function notes {
	Set-Location "$env:USERPROFILE\Meine Ablage\Vaults\Notes"
}

# Load conda only on first use to speed up terminal startup
function conda {
	Remove-Item Function:conda

	#region conda initialize
	# !! Contents within this block are managed by 'conda init' !!
	If (Test-Path "C:\Users\Adnan\miniconda3\Scripts\conda.exe") {
		(& "C:\Users\Adnan\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
	}
	#endregion

	conda @args
}
