<template>
  
  <form>
    <p class="text-danger" v-if="hasErrors">
       {{ formatedErrorMsg }}
    </p>
    <div class="mb-3 row">
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label" v-bind:class="{ 'text-danger': hasErrors }">Company Name *</label>
        <input type="text" class="form-control" v-model="company.name" required>
      </div>
    </div>

    <div class="mb-3 row">
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label">Start Date *</label>
        <input type="date" class="form-control" v-model="contract.start_date" required>
      </div>    
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label">End Date *</label>
        <input type="date" class="form-control" v-model="contract.end_date" required>
      </div>         
    </div>

    <div class="mb-1 row">
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label">Day</label>
        <input type="text" class="form-control" v-model="contract_schedules[0].day" disabled>
      </div>
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label">Start Hour *</label>
        <select class="form-select" v-model="contract_schedules[0].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label">Hour Qty. *</label>
        <select class="form-select" v-model="contract_schedules[0].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>

    <div class="mb-1 row">
      <div class="col">
        <input type="text" class="form-control" v-model="contract_schedules[1].day" disabled>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[1].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[1].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>

    <div class="mb-1 row">
      <div class="col">
        <input type="text" class="form-control" v-model="contract_schedules[2].day" disabled>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[2].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[2].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>

    <div class="mb-1 row">
      <div class="col">
        <input type="text" class="form-control" v-model="contract_schedules[3].day" disabled>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[3].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[3].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>

    <div class="mb-1 row">
      <div class="col">
        <input type="text" class="form-control" v-model="contract_schedules[4].day" disabled>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[4].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[4].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>

    <div class="mb-1 row">
      <div class="col">
        <input type="text" class="form-control" v-model="contract_schedules[5].day" disabled>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[5].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[5].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>

    <div class="mb-4 row">
      <div class="col">
        <input type="text" class="form-control" v-model="contract_schedules[6].day" disabled>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[6].start_hour">
          <option v-for="hour in generateHours">{{hour}}</option>
        </select>
      </div>
      <div class="col">
        <select class="form-select" v-model="contract_schedules[6].hours">
          <option v-for="num in numbers">{{num}}</option>
        </select>
      </div>
    </div>
          
    <div class="mb-3 row">
      <div class="col">
      <button type="button" class="btn btn-primary" @click="sendData">Save changes</button>
      <button type="button" class="btn btn-secondary" @click="hideModal">Close</button>
      </div>
    </div>
  </form>

</template>

<script>
  import _ from 'lodash'
  import axios from 'axios'

  export default {

    data: function(){
      return {
        numbers: this.generateNumbers(),
        hasErrors: false,
        errorsMsg: "",
        company: {
          name: null
        },
        contract: {
          start_date: null,
          end_date: null
        },
        contract_schedules: [
          { day: "monday", hours: 0, start_hour: null },
          { day: "tuesday", hours: 0, start_hour: null },
          { day: "wednesday", hours: 0, start_hour: null },
          { day: "thursday", hours: 0, start_hour: null },
          { day: "friday", hours: 0, start_hour: null },
          { day: "saturday", hours: 0, start_hour: null },
          { day: "sunday", hours: 0, start_hour: null },
        ]
      }
    },

    computed: {
      generateHours: function(){
        return Array.from(Array(24-new Date().getHours()),(x,i)=>('0'+(23-i)).slice(-2)+':00').reverse()
      },

      formatedErrorMsg: function(){
        return this.errorsMsg.join(", ")
      }
    },

    methods: {

      hideModal: function(event){
        this.$emit("hide")
      },

      cleanSchedules: function(){
        return _.filter(this.contract_schedules, function(cs){ return cs.start_hour !== null })
      },

      generateNumbers: function(){
        return _.range(1, 22)
      },

      success: function(response){
        console.log("ok",response)
        window.location.reload()
      },

      handleErrors: function(data){
        this.hasErrors = true
        this.errorsMsg = data
      },

      sendData: function(){
        let self = this
        let formData = {
          company: { 
            name: this.company.name,
            contract_attributes: {
              start_date: this.contract.start_date,
              end_date: this.contract.end_date,
              contract_schedules_attributes: this.cleanSchedules()
            },
          },
        }

        let csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
        let config = {
          headers: { "X-CSRF-Token": csrfToken }
        }

        axios.post("/api/companies", formData, config)
        .then(function(response){
          self.success(response)
        })
        .catch(function(error){
          self.handleErrors(error.response.data)
        })
      }
    }
  
  }

</script>
