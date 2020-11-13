const images = [ "v1.png", "v2.png"]
const home = document.querySelector(".home-backgorund");
// let i = 0;
const changeImg = () => { window.setInterval(function() {
  // home.style.backgroundImage = "image-url(" + images[i] + ")";
  // i = i + 1;
  // if (i == images.length) {
  //   i =  0;
  // }
  home.classList.toggle("home-backgorund-second");
}, 500);
};

export { changeImg };
