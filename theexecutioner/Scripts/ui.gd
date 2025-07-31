extends Control

func update_crime_info(data: Dictionary):
	%NameLabel.text = data["name"]
	%CrimeLabel.text = data["crime"]
	%TraitLabel.text = data["trait"]
