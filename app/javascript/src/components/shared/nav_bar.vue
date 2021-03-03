<template>
  <nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">Guardianes Informaticos SpA</span>
      <div class="d-flex">
        <company-modal></company-modal>
        <user-modal></user-modal>
      </div>
    </div>
  </nav>
</template>

<script>
  import CompanyModal from '../companies/modal.vue'
  import UserModal from '../users/modal.vue'

  export default {
    components: {
      "company-modal": CompanyModal,
      "user-modal": UserModal
    }
  }
</script>