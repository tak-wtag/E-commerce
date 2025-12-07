import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rating", "container"]

  connect() {
    const initial = this.ratingTarget?.value
    this.current = initial ? parseInt(initial) : 0
    this.render()
  }

  setRating(event) {
    const val = parseInt(event.currentTarget.dataset.starsValue, 10)
    if (!isNaN(val)) {
      this.current = (this.current === val) ? 0 : val
      if (this.hasRatingTarget) this.ratingTarget.value = this.current
      this.render()
    }
  }

  render() {
    const buttons = this.element.querySelectorAll('.star')
    buttons.forEach((btn, idx) => {
      btn.textContent = (idx + 1) <= this.current ? '★' : '☆'
    })
  }
}
