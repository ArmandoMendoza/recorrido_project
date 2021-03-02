<template>
  <div>
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-body">
            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeCompany($event)">
              <option selected>Select Company</option>
              <option v-for="company in companies" v-bind:value="company.id">{{company.attributes.name}}</option>
            </select>

            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeWeek($event)">
              <option selected>Select Week</option>
              <option v-for="week in weeks" v-bind:value="week.value">{{week.name}}</option>
            </select>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end" v-if="schedules.length > 0">
              <a class="btn btn-primary" v-bind:href="editUrl" data-turbolinks="false" role="button">Editar Disponibilidad</a>
            </div>
          </div>
        </div>
      </div>
      <br>
    </div>
    <div class="row">
      <schedules-container
        :schedules=schedules
        :total=total
      ></schedules-container>
    </div>
  </div>

</template>

<script>
  import axios from 'axios'
  import CompanySchedulesContainer from '../company_schedules/container.vue'


  export default {
    data: function() {
      return {
        company_id: null,
        editUrl: "#",
        companies: [],
        weeks: [],
        schedules: [],
        total: []
      } 
    },

    methods: {
      onChangeCompany: function(event){
        let value = event.target.value
        if(value !== "Select Company"){
          this.company_id = value
          axios
          .get(`/api/collections/companies/${this.company_id}/weeks`)
          .then((response)=>
            this.weeks = response.data.data
          )
        }else{
          this.company_id = null
          this.weeks = []
          this.schedules = []
          this.total = []
        }
      },

      onChangeWeek: function(event){
        let value = event.target.value
        this.editUrl = `/companies/${this.company_id}/week/${value}`
        if(value !== "Select Week"){
          axios
          .get(`/api/companies/${this.company_id}/schedules`, { params: { week: value } })
          .then((response)=>{
            this.schedules = response.data.data.schedules
            this.total = response.data.data.total
          })
        }else{
          this.schedules = []
          this.total = []
        }
      }
    },

    created: function() {
      axios
      .get("/api/collections/companies")
      .then((response)=>
        this.companies = response.data.data
      )
    },

    components: {
      "schedules-container": CompanySchedulesContainer
    }

  }
</script>