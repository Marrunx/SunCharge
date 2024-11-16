function rowSelector(){
const table = document.getElementById('cards-table');

const deployBtn = document.getElementById('deploy-btn');
const returnBtn = document.getElementById('return-btn');

const cardNumRow = document.getElementById('cardNumber');
const cardUserRow = document.getElementById('cardUser');
const cardTakenRow = document.getElementById('cardTaken');

const cardNumDeploy = document.getElementById('cardUID2');
const cardNumReturn = document.getElementById('cardUID3');
 

table.addEventListener('click', function(event){
    if(event.target.tagName === 'TD'){

         const row = event.target.parentNode;

        Array.from(table.getElementsByTagName('tr')).forEach(r => r.classList.remove('selected'));

        row.classList.add('selected');

        const cells = row.getElementsByTagName('td');
            
        const cardNum = cells[0].textContent;
        const cardUser = cells[1].textContent;
        const cardTaken = cells[2].textContent;

        cardNumRow.textContent = cardNum;
        cardUserRow.textContent= cardUser;
        cardTakenRow.textContent = cardTaken;

        cardNumDeploy.textContent = cardNum;
        cardNumReturn.textContent = cardNum;

        //set value inside the text box for card id
        document.getElementById('cardID').value = cardNum;
        document.getElementById('cardID2').value = cardNum;

        if(cardUser.toLowerCase() === 'none'){
            deployBtn.style.display = 'block';
            returnBtn.style.display = 'none';
        }else{
            deployBtn.style.display = 'none';
            returnBtn.style.display = 'block'
        }
    }
})
}

function deployPopUp(){
    const deployPopUp = document.getElementById('deploy-btn');
    const closeBtn = document.getElementById('close-btn');

    const popUp = document.getElementById('deploy-popUp');
    const dimBackground = document.getElementById('dim-background');

    //open deploy pop up button
    deployPopUp.addEventListener('click', () =>{
        popUp.style.display = 'flex';
        dimBackground.style.display = 'flex';
    });
    
    //close by x icon
    closeBtn.addEventListener('click', () =>{
        popUp.style.display = 'none';
        dimBackground.style.display = 'none';
    });

    //close
    window.addEventListener('click', (event) =>{
        if(event.target === popUp){
        popUp.style.display = 'none';
        dimBackground.style.display = 'none'}
    });
}

function deployReturn(){
    const returnPopUp = document.getElementById('return-btn');
    const closeBtn = document.getElementById('return-close-btn');
    const returnCancel = document.getElementById('return-cancel-btn');

    const popUp = document.getElementById('return-popUp');
    const dimBackground = document.getElementById('dim-background');

    //open deploy pop up button
    returnPopUp.addEventListener('click', () =>{
        popUp.style.display = 'flex';
        dimBackground.style.display = 'flex';
    })

    //close by x icon
    closeBtn.addEventListener('click', () =>{
        popUp.style.display = 'none';
        dimBackground.style.display = 'none';
    });

    //close by cancel icon
    returnCancel.addEventListener('click', ()=>{
        popUp.style.display = 'none';
        dimBackground.style.display = 'none';
    })
    //close
    window.addEventListener('click', (event) =>{
        if(event.target === popUp){
        popUp.style.display = 'none';
        dimBackground.style.display = 'none'}
    });

}

function historyPopUp(){
    const historyBtn = document.getElementById('history-btn');

    const historyClose = document.getElementById('history-close');

    const historyMain = document.getElementById('history-main');
    const dimBackground = document.getElementById('dim-background');

    historyBtn.addEventListener('click', ()=>{
        historyMain.style.display = 'flex';
        dimBackground.style.display = 'block';
    })

    historyClose.addEventListener('click', ()=>{
        historyMain.style.display = 'none';
        dimBackground.style.display = 'none';
    })
}

rowSelector();

deployPopUp();
deployReturn();
historyPopUp();


