import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import NavBar from '../src/components/shared/nav_bar.vue'
import UserSelector from '../src/components/user_selector/form.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',
    components: { 
      "nav-bar": NavBar,
      "user-selector": UserSelector
    }
  })
})
