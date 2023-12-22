<template>
    <Layout>
    </Layout>
    <div class="container">
        <h1>Currency Dashboard</h1>
        <div class="overall-status">
            <p>Timestamp: {{ timestamp }}</p>
            <p>Total currencies: {{ totalCurrencies }}</p>
        </div>
        <div class="button-1">
            <button @click="filterData('price')">Filter by Price</button>
        </div>
        <div class="currency-list">
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Symbol</th>
                        <th>Price</th>
                        <th>Market Cap</th>
                        <th>24h Change</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="currency in currencies.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage)"
                        :key="currency.id">
                        <td>{{ currency.name }}</td>
                        <td>{{ currency.symbol }}</td>
                        <td style="text-align: end;">{{ currency.quote.USD.price.toLocaleString('en-US',
                            { minimumFractionDigits: 3, maximumFractionDigits: 3 }) }}</td>
                        <td style="text-align: end;">{{ currency.quote.USD.market_cap.toLocaleString('en-US',
                            { minimumFractionDigits: 3, maximumFractionDigits: 3 }) }}</td>
                        <td style="text-align: end;">{{ currency.quote.USD.percent_change_24h.toLocaleString('en-US',
                            { minimumFractionDigits: 3, maximumFractionDigits: 3 }) }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
      
        <div class="pagination">
            <button @click="goToPage(1)">First</button>
            <button @click="goToPreviousPage">Previous</button>
            <span v-for="page in Math.min(totalPages, 5)" :key="page">
                <button :class="{ active: currentPage === page }" @click="goToPage(page + currentPage - 1)">{{ page + currentPage - 1 }}</button>
            </span>
            <button @click="goToNextPage">Next</button>
            <button @click="goToPage(totalPages - 1)">Last</button>
            <p>Total pages: {{ totalPages }}</p>
        </div>
    </div>
</template>
  
  
<script>
import axios from "axios";

export default {
    name: "CurrencyDashboard",
    data() {
        return {
            currencies: [],
            timestamp: "",
            totalCurrencies: 0,
            asc: true,
            currentPage: 1,
            itemsPerPage: 20, // Adjust as needed
            totalPages: 0,
        };
    },
    mounted() {
        axios
            .get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=500&convert=USD', {
                headers: {
                    'X-CMC_PRO_API_KEY': '85c09f10-3602-4ef2-828b-a8407b9b23e4',
                },
            })
            .then((response) => {
                this.timestamp = response.data.status.timestamp;
                this.totalCurrencies = response.data.status.total_count;
                this.currencies = response.data.data;
                this.totalPages= response.data.status.total_count / this.itemsPerPage
                console.log(response);
            })
            .catch((error) => {
                console.log(error);
            });
    },
    filters: {
        currencyFormat(value) {
            return new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'USD',
            }).format(value);
        },
        percentFormat(value) {
            return new Intl.NumberFormat('en-US', {
                style: 'percent',
                maximumFractionDigits: 2,
            }).format(value);
        },
    },
    methods: {
        filterData(filterBy) {
            if (filterBy === 'price') {
                this.asc = !this.asc; // Toggle asc on each click
                this.currencies.sort((a, b) => {
                    return this.asc
                        ? a.quote.USD.price - b.quote.USD.price // Ascending
                        : b.quote.USD.price - a.quote.USD.price; // Descending
                });
            } else {
                // Handle other filters if needed
            }
        },
        goToPage(page) {
            this.currentPage = page;
            this.fetchData(); // Refetch data for the new page
        },
        goToPreviousPage() {
            this.goToPage(this.currentPage - 1);
        },
        goToNextPage() {
            this.goToPage(this.currentPage + 1);
        },
    },
};
</script>
  