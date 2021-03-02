<template>
  <div>
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-body">
            <h1>{{data_company.attributes.name}}</h1>
            <h2>Week {{week}}</h2>
            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeUser($event)">
              <option selected>Select User</option>
              <option v-for="user in users" v-bind:value="user.id">{{user.attributes.name}}</option>
            </select>        
            
            <div class="d-grid gap-2 d-md-flex">
              <a class="btn btn-secondary" href="/" data-turbolinks="false" role="button">Volver</a>
            </div>
          
          </div>
        </div>
      </div>
    </div>


    <div class="row">
      <schedules-container
        v-bind:schedules="schedules"
        v-bind:user="user"
      ></schedules-container>
    </div>
  </div>

</template>

<script>
  import axios from 'axios'
  import UserScheduleContainer from '../user_schedules/container.vue'
  import _ from 'lodash'

  export default {
    props: ["company", "week"],
    
    data: function(){
      return {
        data_company: this.company.data,
        users: [],
        schedules: [],
        user: null
      }
    },
    
    methods: {
      onChangeUser: function(event){
        let value = event.target.value
        if(value !== "Select User"){
          this.user = _.find(this.users, function(u){ return u.id === value })
          axios
          .get(`/api/companies/${this.data_company.id}/users/${this.user.id}/schedules`, { params: { week: this.week } })
          .then((response)=>{
            this.schedules = response.data.data
          })    
        }else{
          this.schedules = []
          this.user = null
        }
      }
    },

    created: function(){
      axios
      .get(`/api/collections/companies/${this.data_company.id}/users`)
      .then((response)=>
        this.users = response.data.data
      )
    },

    components: {
      "schedules-container": UserScheduleContainer
    }

  }
</script>