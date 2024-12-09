//universal objects


function addCard(){
    //add card button
    const addButton = document.getElementById('add-card-btn');
    const addClose = document.getElementById('add-close');

    //add card forms window
    const addCardWindow = document.getElementById('locker-settings');
    const dimBackground = document.getElementById('dim-background');

    addButton.addEventListener('click', ()=>{
        dimBackground.style.display = 'flex';
        addCardWindow.style.display = 'block';
    })

    addClose.addEventListener('click', ()=>{
        dimBackground.style.display = 'none';
        addCardWindow.style.display = 'none';
    })
}

function editCard(){
    const editButton = document.getElementById('edit-card');
    const editClose = document.getElementById('edit-close')

    //edit window
    const editWindow = document.getElementById('edit-popUp');
    const dimBackground = document.getElementById('dim-background');


    editButton.addEventListener('click', ()=>{
        dimBackground.style.display = 'flex';
        editWindow.style.display = 'block';
    })

    editClose.addEventListener('click', ()=>{
        dimBackground.style.display = 'none';
        editWindow.style.display = 'none';
    })
}

function addBalance(){
    const addBalanceButton = document.getElementById('add-balance');
    const balanceClose = document.getElementById('bal-close');

    //balance window
    const dimBackground = document.getElementById('dim-background');
    const addBalWindow = document.getElementById('balance-popUp');

    addBalanceButton.addEventListener('click', ()=>{
        dimBackground.style.display = 'block';
        addBalWindow.style.display = 'flex';
    })

    balanceClose.addEventListener('click', ()=>{
        dimBackground.style.display = 'none';
        addBalWindow.style.display = 'none';
    })
}

function rowSelector(){
            // Get the table element
        const table = document.getElementById('scrollable-table');

        //hidden text boxes
        const editHidden = document.getElementById('edit-card-id');
        const balHidden = document.getElementById('balance-card-id')

        const selectedID = document.getElementById('selected-id')
        const hiddenBottom = document.getElementById('selected-card-id');

        //Headers to display locker number
        const headerEdit = document.getElementById('edit-header');
        const headerBal = document.getElementById('bal-header')
        
        // Add a click event listener to the table
        table.addEventListener('click', function(event) {
            // Check if a table cell (td) was clicked
            const target = event.target;
            if (target.tagName === 'TD') {
                // Get the row of the clicked cell
                const row = target.parentElement;

                // Get the value of the first column in the row
                const firstColumnValue = row.cells[0].textContent;
                const status = row.cells[1].textContent;

                // Display the value in the headers
                selectedID.textContent = firstColumnValue;
                hiddenBottom.value = firstColumnValue

                //display the locker in headers
                headerEdit.textContent = firstColumnValue;
                headerBal.textContent = firstColumnValue;


                //make all the buttons usable
                document.getElementById('add-balance').removeAttribute('disabled');
                document.getElementById('missing-card').removeAttribute('disabled');

                //determine if rent or return card
                if(status === "Unused"){
                    document.getElementById('edit-card').removeAttribute('disabled');
                    document.getElementById('return-card').disabled = true;
                }

                if(status === "Used"){
                   document.getElementById('edit-card').disabled = true;
                   document.getElementById('return-card').removeAttribute('disabled');
                }

                //insert into hidden text boxes
                editHidden.value = firstColumnValue;
                balHidden.value = firstColumnValue;

                //for edit forms
                const usedBy = row.cells[2].textContent;
                const section = row.cells[3].textContent;
                const locker = row.cells[5].textContent;

                //edit forms input text boxes
                document.getElementById('e')
            }
        });

}

rowSelector();
addCard();
addBalance(); 
editCard();