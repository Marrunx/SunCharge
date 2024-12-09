//window
const dimBackground = document.getElementById('dim-background');
const deployWindow = document.getElementById('deploy-popUp');
const returnWindow = document.getElementById('return-popUp');
const activityWindow = document.getElementById('history-main');
const salesWindow = document.getElementById('sales-main');

//hidden text inputs in forms
const lockerNumberHidden = document.getElementById('locker-number-forms');
const returnLockerHidden = document.getElementById('return-locker-hidden');

//buttons
const activityButton = document.getElementById('activity-log');
const salesButton = document.getElementById('sales-record');

//open activity log
activityButton.addEventListener('click', ()=>{
    dimBackground.style.display = 'flex';
    activityWindow.style.display = 'flex';
})

//open sales record
salesButton.addEventListener('click', ()=>{
    dimBackground.style.display = 'block';
    salesWindow.style.display = 'block';
})



//ALKSDJFHKLAJSDFHHJKLSDFAHJKLSDFHAJKLDFSHFJKLS POP UP PER ROWS
// Wait until the DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    // Get all deploy buttons using querySelectorAll
    const deployButtons = document.querySelectorAll('.deploy-btn');
    const returnButtons = document.querySelectorAll('.return-btn');

    //loop over all returnbuttons
    returnButtons.forEach(button =>{
        button.addEventListener('click', function(){
            dimBackground.style.display = 'flex';
            returnWindow.style.display = 'flex';

            const lockerNumber = this.closest('tr').children[0].textContent;

            const returnLockerNumber = document.querySelector('#return-locker-number');

            returnLockerNumber.textContent = `${lockerNumber}`;
            returnLockerHidden.value = `${lockerNumber}`;
        })
    })
    
    // Loop over each button and attach an event listener
    deployButtons.forEach(button => {
        button.addEventListener('click', function() {
            
            dimBackground.style.display = 'flex';
            deployWindow.style.display = 'flex';

            // Get the locker number from the first <td> of the row where the button was clicked
            const lockerNumber = this.closest('tr').children[0].textContent;
            
            // Select the span element to display the locker number
            const displaySpan = document.querySelector('#locker-number');
            // Update the span with the locker number
            displaySpan.textContent = `${lockerNumber}`;
            lockerNumberHidden.value = `${lockerNumber}`;
        });
    });
});



//close windows
const deployClose = document.getElementById('close-btn');

deployClose.addEventListener('click', ()=>{
    dimBackground.style.display = 'none';
    deployWindow.style.display = 'none';
})

//close return window
const returnClose = document.getElementById('return-close-btn');

returnClose.addEventListener('click', ()=>{
    dimBackground.style.display = 'none';
    returnWindow.style.display = 'none';
})

//close activity log
const activityClose = document.getElementById('activity-close');    

activityClose.addEventListener('click', ()=>{
    dimBackground.style.display = 'none';
    activityWindow.style.display = 'none';
})

//close sales windows
const salesClose = document.getElementById('sales-close');

salesClose.addEventListener('click', ()=>{
    dimBackground.style.display = 'none';
    salesWindow.style.display = 'none';
})