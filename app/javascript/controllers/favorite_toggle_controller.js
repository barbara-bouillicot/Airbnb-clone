import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heart"];

  toggle() {
    const listingId = this.heartTarget.dataset.listingId;

    if (this.heartTarget.classList.contains("fa-regular")) {
      // Heart is regular (listing is not in favorites), so add it to favorites
      fetch(`/favorite_listings`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ listing_id: listingId })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Failed to add to favorites');
        }
        // Update heart icon style to solid
        this.heartTarget.classList.replace("fa-regular", "fa-solid");
      })
      .catch(error => {
        console.error(error);
        // Handle error
      });
    } else {
      // Heart is solid (listing is in favorites), so remove it from favorites
      fetch(`/favorite_listings/${listingId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ listing_id: listingId })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Failed to remove from favorites');
        }
        // Update heart icon style to regular
        this.heartTarget.classList.replace("fa-solid", "fa-regular");
      })
      .catch(error => {
        console.error(error);
        // Handle error
      });
    }
  }
}
