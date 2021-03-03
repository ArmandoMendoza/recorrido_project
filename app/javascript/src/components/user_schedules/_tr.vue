<template>

  <tr>
    <td v-bind:class="checkHour" class="text-center">{{ value.hour }} </td>
    <td class="text-center">
      <input
        type="checkbox"
        v-model="value.available"
        @change="onChangeUser($event)"
      >
    </td>
  </tr>

</template>

<script>
  import axios from 'axios'
  
  export default {
    props: ["value", "user", "checked"],
    
    computed: {
      checkHour: function(){
        if(this.value.available)
          return { "active-hour": true }
        else
          return { "inactive-hour": true }
      }
    },

    methods: {
      updateAvailability: function(){
        var action = (this.value.available) ? "set_availability" : "unset_availability"
        var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
        var config = {
          headers: { "X-CSRF-Token": csrfToken }
        }
        axios
        .put(`/api/companies/${this.user.attributes.company_id}/users/${this.user.id}/${action}`, { block: this.value.block }, config)
        .then((response)=>{
          console.log(response.data.available)
          this.value.available = response.data.available
        })        
      },

      onChangeUser: function(event){
        this.updateAvailability()
      }
    },

    watch: { 
      checked: function(newVal, oldVal) { // watch it
        if (newVal !== this.value.available){
          this.value.available = newVal
          this.updateAvailability()
        }
      }
    }  
  }
</script>

<style scoped>
  @import "../../assets/css/main.css"
</style>
