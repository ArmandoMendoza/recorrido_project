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
  export default {
    props: ["value"],
    
    computed: {
      checkHour: function(){
        if(this.value.available)
          return { active: true }
        else
          return { inactive: true }
      }
    },

    methods: {
      onChangeUser: function(event){
        let value = this.value.block
        console.log(value)
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
