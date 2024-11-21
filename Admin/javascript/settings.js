function sideNavigation(){
    //clickable buttons
    const adminBtn = document.getElementById('user-settings-btn');
    const lockerBtn = document.getElementById('locker-settings-btn');

    //windows
    const adminWindow = document.getElementById('user-settings');
    const lockerWindow = document.getElementById('locker-settings');

    adminBtn.addEventListener('click', ()=>{
        //button focus
        adminBtn.style.backgroundColor = 'rgba(0, 0, 0, 0.15)';
        //window appear
        adminWindow.style.display = 'block';
        lockerWindow.style.display = 'none';
        //button unfocus
        lockerBtn.style.backgroundColor = 'rgba(0,0,0,0)';
    })

    lockerBtn.addEventListener('click', ()=>{
        //button focus
        lockerBtn.style.backgroundColor = 'rgba(0,0,0,0.15)';
        //windows appear
        adminWindow.style.display = 'none';
        lockerWindow.style.display = 'block';
        //button unfocus
        adminBtn.style.backgroundColor = 'rgba(0,0,0,0)';
    })
}

sideNavigation();