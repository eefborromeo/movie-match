window.addEventListener('DOMContentLoaded', () => {
    const slides = document.querySelectorAll('#slides .slide');
    let activeSlide = document.querySelector('#slides .slide:first-child');
    const approve = document.querySelector('#approve');
    const decline = document.querySelector('#decline');
    const suggestions = document.querySelector('#suggestions');
    const endOfSuggestions = document.querySelector('#end-of-suggestions');
    activeSlide.classList.add('showing');

    approve.addEventListener('click', addToWatchList);
    decline.addEventListener('click', goToSlide);

    function addToWatchList() {
        fetch(`/approve/${activeSlide.dataset.movieid}`, {
            method: "POST",
        })
        goToSlide()
    }
    
    function goToSlide() {
        activeSlide.classList.remove('showing');
        activeSlide = activeSlide.nextElementSibling;
        if (activeSlide.dataset.id < slides.length - 1) {
            activeSlide.classList.add('showing');
        } else {
            suggestions.classList.add('hide');
            endOfSuggestions.classList.add('show');
        }
    }
})