<template>

  <tr>
    <td v-bind:class="checkHour">{{ value.hour }}</td>
    <td>{{ value.name }}</td>
  </tr>

</template>

<script>
  export default {
    props: ["value"],
    computed: {
      checkHour: function(){
        if(this.value.name === "")
          return { inactive: true }
        else
          return { active: true }
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
