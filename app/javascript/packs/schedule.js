import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import NavBar from '../src/components/shared/nav_bar.vue'
import SelectorForm from '../src/components/selector/form.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',
    components: { 
      "nav-bar": NavBar, 
      "selector-form": SelectorForm 
    }
  })
})
