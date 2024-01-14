import {Controller} from "@hotwired/stimulus";

export class EventDetailsController extends Controller {
  static targets = ["tab"]

  show(event) {
    [...this.element.children].forEach(el => el.hidden = true)
    const el = document.getElementById(event.detail.start_at)
    if (el) {
      el.hidden = false
    }


  }
}