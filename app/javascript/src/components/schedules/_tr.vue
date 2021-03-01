<template>

  <tr>
    <td v-bind:class="checkHour" class="text-center">{{ value.hour }}</td>
    <td v-html="userName" class="text-center"></td>
  </tr>

</template>

<script>
  export default {
    props: ["value"],
    
    computed: {
      checkHour: function(){
        if(this.value.name === null)
          return { inactive: true }
        else
          return { active: true }
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
  .inactive {
    background-color: #FDCECE;
  }
  .active {
    background-color: #DCFDCE;
  }
</style> 
