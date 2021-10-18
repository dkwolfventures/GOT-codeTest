#  Coding Test 

The objective of this excercise is to finish a partially completed application for connecting to an open API (https://anapioficeandfire.com/) providing information about Houses and Characters from the Game of Thrones universe. The completed application should load a list of Houses into a tableview on its initial view, and selecting a House from that table should display a detail view that displays more information about that house, as well as information about a character associated with that house.

This project is written in Objective C, but you may choose to complete it in either Objective C or Swift, whichever you are more comfortable with.

## Tasks

1. **Add the network calls to obtain the House and Character data** 
- Build network calls to retrieve the house and character data from the following API endpoints:
    - Houses - `https://www.anapioficeandfire.com/api/houses?hasWords=true&pageSize=50`
    - Characters - `https://www.anapioficeandfire.com/api/characters/[CHARACTER ID]`
- Include some manner of error handling if the app does not have connectivity or the network calls fail
- Either utilize the provided `GOTHouse` and `GOTCharacter` object classes or create your own for the incoming data

2. **Expand on the provided Models and UI**
- Add an additional field to each of the provided model classes (or your custom class) using data from the APIs
- Add the information from that additional field to the UI in an interesting way

3. **Create a detail view controller for the characters**
- Create a detail view controller for displaying character information. Include all of the information included in the `GOTCharacter` class, as well as the additional fields added in step 2
- The detail view should include a UITable for displaying the character's titles (if available)

4. **Add navigation from the tableView to the detail view**
- Add navigation to the app so that when a row is selected in the table view the corresponding character is displayed in the detail view

5. **Add unit tests, trying to achieve 60% or higher code coverage of the model classes**
