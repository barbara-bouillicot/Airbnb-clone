import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heart"];

  async connect() {
    const listingId = this.heartTarget.dataset.listingId;

    try {
      const response = await fetch(`/favorite_listings/${listingId}/check`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      });

      if (response.ok) {
        const data = await response.json();
        if (data.isFavorite) {
          this.heartTarget.classList.replace("fa-regular", "fa-solid");
        }
      } else {
        throw new Error('Failed to check if listing is favorite');
      }
    } catch (error) {
      console.error(error);
    }
  }


  toggle() {
    const listingId = this.heartTarget.dataset.listingId;

    if (this.heartTarget.classList.contains("fa-regular")) {
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
        this.heartTarget.classList.replace("fa-regular", "fa-solid");
      })
      .catch(error => {
        console.error(error);
      });
    } else {
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
        this.heartTarget.classList.replace("fa-solid", "fa-regular");
      })
      .catch(error => {
        console.error(error);
      });
    }
  }
}
