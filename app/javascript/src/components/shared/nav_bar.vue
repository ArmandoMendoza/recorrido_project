<template>
  <nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">Guardianes Informaticos SpA</span>
      <company-modal></company-modal>
    </div>
  </nav>
</template>

<script>
  import CompanyModal from '../companies/modal.vue'

  export default {
    components: {
      "company-modal": CompanyModal
    }
  }
</script>