<template>

  <tr>
    <td v-bind:class="checkHour" class="text-center">{{ value.hour }}</td>
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
    props: ["value", "user"],
    
    computed: {
      checkHour: function(){
        if(this.value.available)
          return { "active-hour": true }
        else
          return { "inactive-hour": true }
      }
    },

    methods: {
      onChangeUser: function(event){
        var action = (this.value.available) ? "set_availability" : "unset_availability"
        var csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
        var config = {
          headers: { "X-CSRF-Token": csrfToken }
        }
        axios
        .put(`/api/companies/${this.user.attributes.company_id}/users/${this.user.id}/${action}`, { block: this.value.block }, config)
        .then((response)=>
          console.log(response)
        )
      }
    }

  }
</script>

<style scoped>
  @import "../../assets/css/main.css"
</style>
