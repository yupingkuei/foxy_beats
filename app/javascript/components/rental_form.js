const rentalBtn = document.querySelector("#rental-btn");
const rentalForm = document.querySelector("#rental-form");

const showRentalForm = () => {
rentalBtn.addEventListener("click", (event) => {
  // Do something (callback)
  event.preventDefault();
  rentalForm.style.display = "block";
  event.currentTarget.style.display = "none";
});
};

export { showRentalForm };
