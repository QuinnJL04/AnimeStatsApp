const searchButton = document.getElementById('search-button');
const searchBar = document.getElementById('anime-search');

document.getElementById('search-button').addEventListener('click', function() {
    let username = document.getElementById('anime-search').value.toLowerCase();

    if (username === 'bork') {
        const newWindow = window.open('results.html', '_blank');
        if (newWindow) {
            newWindow.focus();
        } else {
            alert('Please allow pop-ups to open the results page.');
        }
    }
    if (username === '') {
        document.getElementById('error-message').textContent = "Please enter a username.";
    } else {
        document.getElementById('error-message').textContent = "Username not found. Please try again.";
    }
});
