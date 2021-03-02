<template>

  <tr>
    <td v-bind:class="checkHour" class="text-center">{{ value.hour }}</td>
    <td v-html="userName" v-bind:style="{backgroundColor: value.color}" class="text-center"></td>
  </tr>

</template>

<script>
  export default {
    props: ["value"],
    
    computed: {
      checkHour: function(){
        if(this.value.name === null)
          return { "inactive-hour": true }
        else
          return { "active-hour": true }
      },

      userName: function(){
        if(this.value.name === null)
          return '<i class="fas fa-exclamation-triangle"></i>&nbsp;<i class="fas fa-exclamation-triangle"></i>'
        else
          return this.value.name
      }   
    }
  }
</script>

<style scoped>
  @import "../../assets/css/main.css"
</style>