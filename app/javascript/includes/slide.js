window.addEventListener('DOMContentLoaded', () => {
    const slides = document.querySelectorAll('#slides .slide');
    let activeSlide = document.querySelector('#slides .slide:first-child');
    const approve = document.querySelector('#approve');
    const decline = document.querySelector('#decline');
    const suggestions = document.querySelector('#suggestions');
    const endOfSuggestions = document.querySelector('#end-of-suggestions');
    activeSlide.classList.add('showing');

    approve.addEventListener('click', () => nextSlide('approve'));
    decline.addEventListener('click', () => nextSlide('decline'));

    function nextSlide(a) {
        goToSlide(a);
    }
    
    function goToSlide(action) {
        if (action === "approve") {
            console.log(action)
        } else {
            console.log(action)
        }

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